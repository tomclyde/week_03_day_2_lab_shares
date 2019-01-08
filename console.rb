require('pry')
require_relative('models/shares.rb')

share1 = Share.new(
  {
    'company' => 'Lloyds',
    'price' => '50',
    'volume' => '100',
      'rating' => 'buy'
    }

)

share2 = Share.new(
  {
    'company' => 'Barclays',
    'price' => '500',
    'volume' => '1000',
      'rating' => 'sell'
    }

)


share3 = Share.new(
  {
    'company' => 'Apple',
    'price' => '3000',
    'volume' => '899000',
      'rating' => 'sell'
    }

)



share1.save()
share2.save()
share3.save()

share3.price = '1'
share3.update()
#
# Share.delete_all()

#share2.delete_company

Share.find_by_name('Lloyds')
Share.find_by_name('abc')
