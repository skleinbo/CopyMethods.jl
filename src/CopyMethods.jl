__precompile__()
module CopyMethods

export copy_col!, copy_row!, unit

function copy_col!{T}(A::AbstractArray{T,2},col1::Int,col2::Int,row_min=0,row_max=Inf)
  @inbounds @simd for i in max(1, row_min):min(size(A,1), row_max)
    A[i,col2] = A[i,col1]
  end
end

function copy_row!{T}(A::AbstractArray{T,2},row1::Int,row2::Int,col_min=0,col_max=Inf)
  for i in max(1, col_min):min(size(A,2), col_max)
    @inbounds A[row2,i] = A[row1,i]
  end
end

function copy_row!{T}(A::AbstractArray{T,1},N::Int, row1::Int,row2::Int)
  if length(A) == 0 || max(row1, row2) > N
      return
  end
  # @printf("%s %s %s %s %s",row1, row2, N, length(A), length(A)/N)
  @inbounds @simd for i in 1:Int(length(A)/N)
    A[ row2+N*(i-1) ] = A[ row1+N*(i-1) ]
  end
end

unit(N,j) = map(x->(if x==j return 1 else 0 end), 1:N)

end
