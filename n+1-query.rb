c_all = Category.all
c_all.each do |c|
	puts c.articles.length
end

c_all = Category.includes(:articles).all

c_all.each do |c|
	puts c.articles.length
end

.includes, .preload, .eagerload
.joins

Category.joins(:articles) - it will generate inner join
inner join means 
	it will check the chail table records, if it has chaild records it will fetch parent record or else it will skip parent record

Category.joins(:articles).map(&:id)

cat 1
	art 1
	art 2
	art 3
cat 2
	art 4
	art 5
cat 3

[1,1,1,2,2]
