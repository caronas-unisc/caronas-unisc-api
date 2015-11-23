require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  test 'generate_date_and_period_query' do
    availabilities = [
      { date: '2015-10-21', period: :morning },
      { date: '2015-10-21', period: :afternoon },
      { date: '2015-10-22', period: :night }
    ]

    query = MatchFinder.generate_date_and_period_query(availabilities)

    assert_equal query, ['(date = ? AND period = ?) OR (date = ? AND period = ?) OR (date = ? AND period = ?)',
      '2015-10-21', :morning, '2015-10-21', :afternoon, '2015-10-22', :night]
  end
end
