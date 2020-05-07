require 'rails_helper'
RSpec.describe "OrdersControllers", type: :request do
  describe "get orders_path" do
    it "renders the index view" do
      FactoryBot.create_list(:order, 10)
      get orders_path
      expect(response.status).to eq(200)
    end
  end
  describe "get orders_path" do
    it "renders the :show template" do
      order = FactoryBot.create(:order)
      get order_path(id: order.id)
      expect(response.status).to eq(200)
    end
  end
  describe "get new_orders_path" do
    it "renders the :new template" do
      get new_order_path
      expect(response.status).to eq(200)
    end
  end
  describe "get edit_orders_path" do
    it "renders the :edit template" do
      order = FactoryBot.create(:order)
      get orders_path(id: order.id)
      expect(response.status).to eq(200)
    end
  end
  describe "post orders_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      order_attributes = FactoryBot.attributes_for(:order)
      expect { post orders_path, params: {order: order_attributes}
    }.to change(Order, :count)
      expect(response).to redirect_to order_path(id: Order.last.id)
    end
  end
  describe "post orders_path with invalid data" do
    it "does not save a new entry or redirect" do
      order_attributes = FactoryBot.attributes_for(:order)
      order_attributes.delete(:product_name)
      expect { post orders_path, params: {order: order_attributes}
    }.to_not change(Order, :count)
      expect(response.status).to eq(200)
    end
  end
  describe "put orders_path with valid data" do
    it "updates an entry and redirects to the show path for the order" do
      order = FactoryBot.create(:order)
      customer = FactoryBot.create(:customer)
      put order_path(id: order.id), params: {order: {customer_id: customer.id}}
      order.reload
      expect(order.customer_id).to eq(customer.id)
      expect(response).to redirect_to order_path(id: order.id)
    end
  end
  describe "put orders_path with invalid data" do
    it "does not update the customer record or redirect" do
      order = FactoryBot.create(:order)
      put order_path(id: order.id), params: {order: {customer_id: 5555}}  # a nonexistent customer
      order.reload
      expect(order.customer_id).to_not eq(5555)
      expect(response.status).to eq(200)
    end
  end
  describe "delete an order record" do
    it "deletes an order record" do
      order = FactoryBot.create(:order)
      expect { delete order_path(id: order.id)
      }.to change(Order, :count)
      expect(response).to redirect_to orders_path
    end
  end
end