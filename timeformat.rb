class TimeFormat

  TIME = { year: '%Y', month: '-%m', day: '-%d', hour: ' %H', minute: ':%M', second: ':%S' }.freeze

  attr_reader :invalid_params

  def initialize(params)
    @params = params
    @invalid_params = @params - TIME.keys.map(&:to_s)
  end

  def valid?
    @invalid_params.empty?
  end

  def result
    Time.now.strftime(call).to_s + "\n"
  end

  def call
    arr = []
    @params.each { |param| arr << TIME[param.to_sym] }
    arr.join
  end

end
