class RankingController < ApplicationController
    def want
      # アイテム ID ごとに集約する（= 束ねる）
      @wants = Want.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id)
      # where だけだと、アイテム ID で限定するだけとなり、順番の保証がない
      # よって、sort_by を使って、意図的にもう1度順番を保証する必要がある
      @items = Item.where(id: @wants.keys).sort_by{|item| @wants.keys.index(item.id)}
    end
    
    def have
      @haves = Have.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id)
      @items = Item.where(id: @haves.keys).sort_by{|item| @haves.keys.index(item.id)}
    end
end
