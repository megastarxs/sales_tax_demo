class SalesTaxModel

    def initialize(attributes={})
        # Initialize all the base values required.
        @items=attributes
        @total=0.0
        @total_tax=0.0

        # Calculate and total the tax for all items
        collect_sales_tax

        # Render the hash directly to be served as json i the view
        export
     end


    def export
        {
            items:@items,
            total:@total,
            total_tax:@total_tax
        }
     end


     def collect_sales_tax

         @items.each{|item|
            apply_sales_tax(item)
            @total+=item[:price]
            @total_tax+= item[:tax]
        }

        # Round the totals as to help with floating point precision issues
        @total=@total.round(2)
        @total_tax=@total_tax.round(2)

     end

     def apply_sales_tax(item)
        item[:price]= item[:price].to_f
        item[:tax]=0
        tax= 0
        tax+=10 if !exempt_tax(item) # Apply basic tax if the item is eligible
        tax+=5 if item[:imported] # Apply import duty tax
        if tax!=0
            original_price= item[:price]
            computed_tax = item[:price]*tax/100 # Calculate the tax
            item[:price]+= computed_tax
            item[:price]= round_point5 item[:price] # Round the price
            item[:tax]= item[:price]-original_price # Calculate the tax with the offset
        end
     end


     def exempt_tax(item)
        item[:name].downcase =~ /book|chocolate|pills/ # Check if the item is a book,food or medicine
     end


     def round_point5(number)
        number=number.round(2)
        unmodded=(number.round(2)*100)
        mod=unmodded%10
        number=(unmodded-mod+5)/100 if mod < 5 && mod!=0 # Check if the last digit after rounding of till two decimals is less than 0.05
        number
    end

end