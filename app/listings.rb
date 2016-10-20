def sort_db

  elements = Assessment.all

  elements = elements.select { |element| !element.score.nil? }
  sorted_results = elements.sort_by { |item| -item.score }

  sorted_results.each do |res|
    user = User.find(res.id)
    p user.username.to_s + ' got a ' + res.score.to_s
    p user.email.to_s
    p "*" * 20
  end

  nil

end

sort_db
