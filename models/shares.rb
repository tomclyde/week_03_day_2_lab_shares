require('pg')

class Share

  attr_accessor :company, :price, :volume, :rating
  attr_reader :id


  def initialize(share_details)
    @company = share_details['company']
    @price = share_details['price']
    @volume = share_details['volume']
    @rating = share_details['rating']
    @id = share_details['id'].to_i if share_details['id']
  end

  def save()
    db = PG.connect({dbname: 'shares', host: 'localhost'})
    sql =
      "INSERT INTO shares
      (company,
        price,
        volume,
        rating)
        VALUES
        ($1, $2, $3, $4)
        RETURNING *"
        values = [@company, @price, @volume, @rating]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def Share.all()
    db = PG.connect({dbname: 'shares', host: 'localhost'})
    sql = "SELECT * FROM shares"
    db.prepare("all", sql)
    companies = db.exec_prepared("all")
    db.close()
    return companies.map {|companies| Share.new(companies)}
  end

  def Share.delete_all()
    db = PG.connect({dbname: 'shares', host: 'localhost'})
    sql = "DELETE FROM shares"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def update
    db = PG.connect({dbname: 'shares', host: 'localhost'})
    sql =
      "UPDATE shares
      SET company = $1,
      price = $2,
      volume = $3,
      rating = $4
      WHERE id = $5
      "
    values = [@company,@price,@volume,@rating,@id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete_company
    db = PG.connect({dbname: 'shares', host: 'localhost'})
    sql =
      "DELETE FROM shares
      WHERE id = $1"
    values = [@id]
    db.prepare("delete_company", sql)
    db.exec_prepared("delete_company", values)
    db.close()

  end

  def Share.find_by_name(company)
    db = PG.connect({dbname: 'shares', host: 'localhost'})
    sql = "SELECT * FROM shares
    WHERE company LIKE '%#{company}%'"

    db.prepare("find_by_name", sql)
    results = db.exec_prepared("find_by_name")
    final_results = results.map {|results| Share.new(results)}
    if final_results.any?
      p final_results
    else
      p nil
    end
    db.close
  end


end
