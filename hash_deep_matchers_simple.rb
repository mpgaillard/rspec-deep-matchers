require 'rspec/expectations'

RSpec::Matchers.define :include_deeply do |sample|
  match do |actual|
    contains_elements?(sample, actual)
  end

  def contains_element?(hash, key, val)
    return false unless hash.class.eql?(Hash)
    included = false

    hash.each do |k, v|
      unless included
        included = (v==val && k==key) ? true : contains_element?(v, key, val)
      end
    end
    included
  end

  def contains_elements?(sample, actual)
    sample.to_a.map{ |key_val| contains_element?(actual, key_val[0], key_val[1]) }.all?
  end
end

#example usage
expect({ ca: 'sdf', ba: { da: {fa: 'bg'} }, la: 's' }).to include_deeply(la: 's', da: {fa: 'bg'}, fa: 'b')