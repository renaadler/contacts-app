class ContactsController < ApplicationController
  def index
    if current_user
      # @contacts = current_user.contacts
      search_terms = params[:search_terms]
      if search_terms
        @contacts = current_user.contacts.where("first_name iLIKE ? OR last_name iLIKE ? OR email iLIKE ? OR phone_number iLIKE ? OR middle_name iLIKE ? OR bio iLIKE ?", "%" + search_terms + "%", "%" + search_terms + "%", "%" + search_terms + "%", "%" + search_terms + "%", "%" + search_terms + "%", "%" + search_terms + "%")
      else
        @contacts = current_user.contacts
      end

      group_name = params[:group]
      if group_name
        group = Group.find_by(name: group_name)
        @contacts = group.contacts
      end
      
      render "index.html.erb"
    else
      flash[:warning] = "You must log in to see your contacts."
      redirect_to '/login'
    end
  end

  def new
    @contact = Contact.new
    render "new.html.erb"
  end

  def create
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      user_id: current_user.id
      )
    if @contact.save
      flash[:success] = "Contact created."
      redirect_to "/contacts/#{@contact.id}"
    else
      render "new.html.erb"
    end
  end

  def show
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    render "show.html.erb"
  end

  def edit
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    render "edit.html.erb"
  end

  def update
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    @contact.update(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio]
    )
    redirect_to "/contacts/#{@contact.id}"
  end

  def destroy
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    @contact.destroy
    redirect_to "/contacts"
  end
end
