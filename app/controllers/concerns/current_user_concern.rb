module CurrentUserConcern
  def current_user
    super || guest_user
  end

  protected

    def guest_user
      GuestUser.new(
        name: "Guest User",
        email: "guest@example.com"
      )
    end
end
