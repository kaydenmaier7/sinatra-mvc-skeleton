helpers do

  MAX_SCORE = 100;

  def assessment
    if logged_in?
      @assessment = Assessment.find_by(user_id: @user.id)
    end
  end

  def completed_at
    assessment.updated_at.strftime('%b-%d-%Y')
  end


  def shorten(results)
    shortened_results = {}
    results['personality_types'].each do |personality|
      shortened_results[personality['personality_type']['name']] = personality['score']
    end
    return shortened_results
  end

  def rate_short_results(results_arr)

    return MAX_SCORE - 1

  end

  def traitify_results

    access = User.traitify_access

    results = access.find_results(assessment.key)

    short_results = shorten(results)

    rate_short_results(short_results)

  end

end
