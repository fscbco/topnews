module Limitable
  attr_reader :limit

  private

  def limit?
    limit.present?
  end

  def greater_than_limit?(object)
    return false unless limit?
    # Check to see if they are passing an object whose elements
    # can be counter; if so, use that to test our limit...
    return object.count > limit if object.respond_to?(:count)

    # ...otherwise, assume we've been passed an integer.
    object > limit
  end

  def validate_limit!
    # Allow a positive integer or nil; don't worry about object type checking.
    raise ArgumentError, 'limit is not positive?' unless limit&.positive? || false
  end
end
