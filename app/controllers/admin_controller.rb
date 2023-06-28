class AdminController < ApplicationController
  before_action :set_stat, only: %i[ show edit update destroy ]

  # GET /admin or /admin.json
  def index
  end
end
