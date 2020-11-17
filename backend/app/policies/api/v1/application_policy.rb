module Api::V1
  class ApplicationPolicy < ActionPolicy::Base
    # default context is user, but we use account as context
    authorize :user

    # private

    # Define shared methods useful for most policies.
    # For example:

    #  def owner?
    #    record.user_id == user.id
    #  end
  end
end
