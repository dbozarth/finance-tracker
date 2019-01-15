class Stock < ActiveRecord::Base
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.new_from_lookup(symbol)
    begin
      stock = StockQuote::Stock.quote(symbol)
      new(name: stock.company_name, ticker: stock.symbol, last_price: stock.latest_price)
    rescue Exception => e
      return nil
    end
  end

end
