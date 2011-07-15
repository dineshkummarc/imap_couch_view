ImapCouchView::Application.routes.draw do
  match 'imap_view' => 'imap_view#index', :as => :imap_index
  match 'imap_view/show/:id' => 'imap_view#show',
      :constraints => {:id => /[^\/]+/},
      :as => :imap_show
  match 'imap_view/show_html/:id' => 'imap_view#show_html',
      :constraints => {:id => /[^\/]+/},
      :as => :imap_show_html
  root :to => "imap_view#index"
end
