module PageHelper
  def item_list items
    items.count > 2 ? items.first(2) : items
  end

  def count_verbiage items
    items.count > 2 ? " & #{items.count - 2} #{'other'.pluralize}" : ""
  end

  def user_name_list items
    item_list(items).map{|i| i.user.name}.join(", ") + count_verbiage(items)
  end
end
