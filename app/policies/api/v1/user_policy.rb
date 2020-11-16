module Api::V1
  class UserPolicy < Api::V1::ApplicationPolicy
    def create?
      true # no authorization needed
    end
  end
end
