function y = log_loss(x, y)
  f_x = sigmoid(x);
  y = -(y.* log(f_x) + (1 - y).* log(1 - f_x));
endfunction