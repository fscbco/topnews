module PageHelper
  def item_list items
    items.count > 2 ? items.first(2) : items
  end

  def count_verbiage items
    reduced_count = items.count - 2
    items.count > 2 ? " & #{reduced_count} #{'other'.pluralize(reduced_count)}" : ""
  end

  def user_name_list items
    item_list(items).map{|i| i.user.name}.join(", ") + count_verbiage(items)
  end
end
