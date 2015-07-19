f1,f2,f3=0,1,1
puts "请输入一个1-100的数字"
while (n=(STDIN.gets).to_i)<1
puts "输入有误"
end
puts "1-#{n}的斐波那契数列如下"
puts 1 if n==1
while f3<n
puts f3
f3=f2+f1
f1,f2=f2,f3
end

