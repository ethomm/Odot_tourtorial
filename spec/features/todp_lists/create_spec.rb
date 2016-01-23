require 'spec_helper'
	describe "Createing todo lists"  do
		def create_to_do_list(options={})
			options [:title] ||= "My todo list"
			options [:description] ||= "This is my todo list."

			visit "/todo_lists"
			click_link "New Todo list"
			expect(page).to have_content("New Todo List")

			fill_in "Title", with: options [:title]
			fill_in "Description", with: options [:description]
			click_button "Create Todo list"


		end

	it "redirects to the todolist index page on success" do
			create_to_do_list

			expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		create_to_do_list title: ""

			expect(page).to have_content("error")
			expect(TodoList.count).to eq(0)

			visit "/todo_lists"
			expect(page).to_not have_content("This is what I'am doing today.")
	end

	it "displays an error when the todo list has a title less than 3 charactes" do
		expect(TodoList.count).to eq(0)

		create_to_do_list title: "Hi"
			expect(page).to have_content("error")
			expect(TodoList.count).to eq(0)

			visit "/todo_lists"
			expect(page).to_not have_content("This is what I'am doing today.")
	end

	it "displays an error when the todo list has no description less than 3 charactes" do
		expect(TodoList.count).to eq(0)

		create_to_do_list description: ""

			expect(page).to have_content("error")
			expect(TodoList.count).to eq(0)

			visit "/todo_lists"
			expect(page).to_not have_content("Grocery list")
	end

	it "displays an error when the todo list has no description less than 3 charactes" do
		expect(TodoList.count).to eq(0)

		create_to_do_list description: "Food"

			expect(page).to have_content("error")
			expect(TodoList.count).to eq(0)

			visit "/todo_lists"
			expect(page).to_not have_content("Grocery list")
	end


end
