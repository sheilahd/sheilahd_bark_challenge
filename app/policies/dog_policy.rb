class DogPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user_id: @user.try(:id))
    end
  end
  def new? ; user_is_owner_of_record? ; end
  def create? ; user_is_owner_of_record? ; end

  def show?
    user_is_owner_of_record? || record
  end
  def edit? ; user_is_owner_of_record? ; end
  def update? ; user_is_owner_of_record? ; end
  def destroy? ; user_is_owner_of_record? ; end


  private

  def user_is_owner_of_record?
    @user == @record.user
  end
end
