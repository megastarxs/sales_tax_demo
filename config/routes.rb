SalesTax::Application.routes.draw do

  get "sales_tax/index"
  post "sales_tax/compute"
  root :to => 'sales_tax#index'

end
