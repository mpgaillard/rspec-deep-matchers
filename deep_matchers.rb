require 'rails_helper'

RSpec::Matchers.define :include_deeply do |sample|
  match do |actual|
    contains_elements?(sample, actual)
  end

  def hash_iter(hash, key, val)
    included = false

    hash.each do |k, v|
      unless included
        included = (v==val && k==key) ? true : contains_element?(v, key, val)
      end
    end
    included
  end

  def array_iter(array, key, val)
    included = false

    array.each do |element|
      unless included
        included = contains_element?(element, key, val)
      end
    end
    included
  end

  def contains_element?(collection, key, val)
    return false unless collection.respond_to?(:each)

    collection.is_a?(Hash) ? hash_iter(collection, key, val) : array_iter(collection, key, val)
  end

  def contains_elements?(sample, actual)
    sample.to_a.map{ |key_val| contains_element?(actual, key_val[0], key_val[1]) }.all?
  end
end

