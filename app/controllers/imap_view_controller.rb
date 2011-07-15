class ImapViewController < ApplicationController

  def index
    q = params[:q].blank? ? '' : params[:q].downcase
    page = params[:page] || 1
    per_page = 25
    skip = per_page * (page.to_i - 1)

    @emails = WillPaginate::Collection.create(page, per_page) do |pager|
      result = @@db.view(VIEW_NAME, {
                      :reduce => false,
                      :limit => pager.per_page,
                      :descending => 'true',
                      :startkey => [q, {}],
                      :endkey => [q, nil],
                      :skip => skip
                    })['rows'].map do |row|
                      {
                        :id => CGI::escape(row['id']),
                        :name => row['key'][0],
                        :date => row['key'][1].to_date,
                        :status => row['key'][2],
                        :subject => row['value']
                      }
                    end
      pager.replace(result)

      total = @@db.view(VIEW_NAME, {
                      :reduce => true,
                      :group_level => 1,
                      :startkey => [q, nil],
                      :endkey => [q, {}]
              })['rows'].pop

      if total
        pager.total_entries = total['value']
      else
        pager.total_entries = 0
      end
    end

  end

  def show
    @doc = @@db.get(params[:id])
    unless @doc['html_body'].blank?
      @html_src = imap_show_html_path(@doc['id'])
    else
      @html_src = nil
    end
  end

  def show_html
    @doc = @@db.get(params[:id])
    render :layout => false
  end

end
