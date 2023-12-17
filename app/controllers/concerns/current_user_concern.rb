module CurrentUserConcern
  def current_user
    super || guest_user
  end

  protected

    def guest_user
      OpenStruct.new(
        name: "Guest User",
        email: "guest@email.com"
      )
    end
end
