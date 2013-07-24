class Article < SuperClass
  attr_accessor :title, :body, :category
end

Sunspot.setup(Post) do
  text :title
end

Sunspot.setup(Article) do
  text :title
  text :body
end
