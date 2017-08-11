class Sorting
  def bubble_sort(array)
    raise unless array.is_a?(Array)

    if array_is_less_then_one?(array)
      "this #{array} do can not be sorted"
    else
      i = 1
      array_size = array.size
      p array
      while i < array_size
        j = 0
        while j < array_size - i
            if array[j] > array[j+1]
              swap_numbers_in_array(array, j, j+1)
            end
          j += 1
        end
        p array
        i += 1
      end
    end
  end

  def array_is_less_then_one?(array)
    if array.empty? || array.size == 1
      true
    else
      false
    end
  end

  def swap_numbers_in_array(array, left_number_index, right_number_index)
    holder = array[left_number_index]
    array[left_number_index] = array[right_number_index]
    array[right_number_index] = holder
    array
  end
end

need_to_be_sorted = [1,8,3,5,4,10,100,8]
smart_sort = Sorting.new
puts smart_sort.bubble_sort(need_to_be_sorted)