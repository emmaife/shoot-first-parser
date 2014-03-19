class User < ActiveRecord::Base
  has_many :combat_parsers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# def create
#   @user = User.find(params[:user_id])
#   @user.combat_parsers.build(params[:user][:combat_parser])
#   if @user.save
#     flash[:notice] = "Combat Parser created successfully"
#     redirect_to user_combat_parser_path(@user)
#   else
#     render :new
#   end
# end

end
