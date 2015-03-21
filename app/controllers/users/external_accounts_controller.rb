module Users
  class ExternalAccountsController < ApplicationController
    skip_after_action :verify_authorized

    def index
      @user = current_user
      @accounts = @user.external_accounts
    end

    def destroy
      @account = ExternalAccount.find(params[:id])
      @account.destroy

      redirect_to user_external_accounts_path, notice: t(
        'flash.users.external_accounts.destroy',
        provider: @account.provider.titleize
      )
    end
  end
end
