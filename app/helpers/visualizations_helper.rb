module VisualizationsHelper

    def empty_option
        [["-", ""]]
    end

    def get_form_variable_names
       empty_option + Student.column_names.reject {|c| ["id", "student_id", "updated_at", "created_at"].include? c}
    end


    def get_form_chart_types
        # Each element has format [<Display Name>, <Value>]
        empty_option +
        [
            ["Bar", "bar_chart"],
            ["Pie", "pie_chart"],
            ["Line", "line_chart"]
        ]
    end


    def get_form_variable_roles
        # Each element has format [<Display Name>, <Value>]
        empty_option +
        [
            ["Group", "group"],
            ["Independent (Group)", "independent"],
            ["Dependent", "dependent"],
        ]
    end


    def get_form_filter_types
        empty_option +
        [
            ["From..To", "from_to"],
            ["Equals", "equals"],
            ["Is Greater Than", "greater_than"],
            ["Is Greater Than Or Equal To", "greater_than_or_equal"],
            ["Is Less Than", "less_than"],
            ["Is Less Than Or Equal To", "less_than_or_equal"]

        ]
    end

    def get_form_summarize_methods
        empty_option +
        [
            ["count"],
            ["sum"],
            ["maximum"],
            ["minimum"]
        ]
    end

   def get_visualization_data(visualization)
       data = Student.all
       
       #Find a way to repeatedly apply all filters for each filter in the visualization
       visualization.filters.each filter do
           
           filter_type = filter.filter_type
           filter_variable_name = filter.variable_name
           filter_value1 = filter.value1
           
           filter_hash = Hash.new
           filter_hash[filter_variable_name] = filter_value1
           
           if filter_type == 'equals'
               data = data.where(filter_hash)
           end
       end
       
       
       # After filtering group the data by some variable(s)
        
       
       return data.group(:major1)
   end


    # Applies a single filter on the dataset
    def apply_filter(data, filter_model)
    end


    def set_variable(data, variable_model)
        
        role = variable_model.role
        variable_name = variable_model.name
        calculation = variable_model.calculation

        case role
        when 'group'
            data = data.group(variable_name)
        else
            data
        end
    end


    def summarize(data, summarization_method)
        case summarization_method
        when 'sum'
            data = data.sum()
        when 'count'
            data = data.count()
        end
    end


end
