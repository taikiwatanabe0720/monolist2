class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new
    if params[:q]
      response = RakutenWebService::Ichiba::Item.search(
        keyword: params[:q],
        imageFlag: 1,
      )
      @items = response.first(20)
    end
  end

  def show
  end

  def read
    code = result.code
    name = result['itemName']
    url = result.url
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')

    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
  
  private
  def set_item
    @item = Item.find(params[:id])
  end
end
