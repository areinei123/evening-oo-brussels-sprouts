require 'pg'


class Ingredient
	def initialize (quantity, unit, name)
		@quantity = quantity
		@unit = unit
		@name = name
	end

	def summary
		"#{@quantity} #{@unit} #{@name}"
	end

	def allergy_checker (name)
	not_allergic = ["brussels sprouts","spinach","eggs","milk","tofu","seitan","bell peppers","quinoa","kale","chocolate","beer","wine","whiskey"]
	not_allergic.include?(name)
	end

end

class Recipe
	def initialize (name, instructions, ingredients)
		@name = name
		@instructions = instructions
		@ingredients = ingredients
		db_connection do |conn|
			conn.exec_params("INSERT INTO recipes (name) VALUES ($1)", [name])
		end
	end

	def db_connection
		begin
			connection = PG.connect(dbname: "whatever")
			yield(connection)
		ensure
	  	connection.close
		end
	end

	def summary
		puts "Name: #{@name} \n\nIngredients"
		@ingredients.each do |ingredient|
			puts "- #{ingredient.summary}"
		end
		puts"\nInstructions"
		count = 1
		@instructions.each do |step|
		puts	"#{count}. #{step}"
			count = count + 1
		end
	end
end


name = "Roasted Brussels Sprouts"

ingredients = [
    Ingredient.new(1.5, "lb(s)", "Brussels sprouts"),
    Ingredient.new(3.0, "tbspn(s)", "Good olive oil"),
    Ingredient.new(0.75, "tspn(s)", "Kosher salt"),
    Ingredient.new(0.5, "tspn(s)", "Freshly ground black pepper")
]

instructions = [
    "Preheat oven to 400 degrees F.",
    "Cut off the brown ends of the Brussels sprouts.",
    "Pull off any yellow outer leaves.",
    "Mix them in a bowl with the olive oil, salt and pepper.",
    "Pour them on a sheet pan and roast for 35 to 40 minutes.",
    "They should be until crisp on the outside and tender on the inside.",
    "Shake the pan from time to time to brown the sprouts evenly.",
    "Sprinkle with more kosher salt ( I like these salty like French fries).",
    "Serve and enjoy!"
    ]

recipe = Recipe.new(name, instructions, ingredients)
recipe.summary
