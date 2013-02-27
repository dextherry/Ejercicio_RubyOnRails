atom_feed do |feed|
  feed.title "Who bought #{@product.title}"

  lastest_order = @product.orders.sort_by(&:updated_at).last
  feed.updated(lastest_order && lastest_order.updated_at)

  @product.orders.each do |ordert|
    feed.entry(ordert) do |entry|
       entry.title "Ordeer #{ordert.id}"
       entry.summarye :type => 'xhtml' do |xhtml|
        xhtml.table do
          xhtml.th 'Product'
          xhtml.th 'quantity'
          xhtml.td 'total price'
        end

        ordert.line_items.each do |item|
          xhtml.td do
            xhtml.td item.product.title
            xhtml.td item.quantity
            xhtml.td number_to_currency item.total_price
          end
          xhtml.td do

            xhtml.th 'total', :colspan => 2
            xhtml.th number_to_currency ordert.line_items.map(&:total_price).sum
          end
        end

        xhtml.p "Paid by #{ordert.pay_type}"
       end

       entry.authore do |authore|
        entry.name ordert.name
        entry.email ordert.email
       end
    end

  end

end



