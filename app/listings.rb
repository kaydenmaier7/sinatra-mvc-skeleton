def database_pretty

  sorted_results = arr.sort_by { |item| [item.score ? 0 : 1, item.score || 0] }

  sorted_results.reverse!

  sorted_results.each do |res|

    if res.score
      user = User.find(res.id)
      p user.username + ' got a ' + res.score.to_s
      p user.email
      p "*" * 20
    end

  end

end

