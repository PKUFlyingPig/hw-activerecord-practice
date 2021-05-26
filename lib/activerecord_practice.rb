require 'sqlite3'
require 'active_record'
require 'byebug'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'customers.sqlite3')

class Customer < ActiveRecord::Base
  def to_s
    "  [#{id}] #{first} #{last}, <#{email}>, #{birthdate.strftime('%Y-%m-%d')}"
  end

  #  NOTE: Every one of these can be solved entirely by ActiveRecord calls.
  #  You should NOT need to call Ruby library functions for sorting, filtering, etc.
  
  def self.any_candice
    # YOUR CODE HERE to return all customer(s) whose first name is Candice
    # probably something like:  Customer.where(....)
    Customer.where(:first => "Candice")
  end

  def self.with_valid_email
    # YOUR CODE HERE to return only customers with valid email addresses (containing '@')
    Customer.where("email like '%@%'")
  end
  # etc. - see README.md for more details

  def self.with_dot_org_email
    Customer.where("email like '%@%.org'")
  end

  def self.with_invalid_email
    Customer.where("email not like '%@%'")
  end

  def self.with_blank_email
    Customer.where("email is null")
  end

  def self.born_before_1980
    Customer.where("birthdate < '1980-01-01'")
  end

  def self.with_valid_email_and_born_before_1980
    Customer.where("birthdate < '1980-01-01'").where("email like '%@%'")
  end

  def self.last_names_starting_with_b
    Customer.where("last like 'B%'").order("birthdate")
  end

  def self.twenty_youngest
    Customer.order("birthdate DESC").limit(20)
  end

  def self.update_gussie_murray_birthdate
    Customer.where("first = 'Gussie' AND last = 'Murray'").first.update(birthdate: '2004-02-08')
  end

  def self.change_all_invalid_emails_to_blank
    Customer.where("email not like '%@%'").update_all("email = ''")
  end

  def self.delete_meggie_herman
    Customer.destroy_all(:first => 'Meggie', :last => 'Herman')
  end

  def self.delete_everyone_born_before_1978
    Customer.where("birthdate < ?", Time.parse('31 Dec 1977')).destroy_all()
  end



end
