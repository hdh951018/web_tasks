f1,f2,f3=0,1,1
puts "请输入一个1-100的数字,输入0直接退出"
s=gets.chomp
while((s.to_i.to_s != s)||(s.to_i<1)||(s.to_i>100))
	exit if ((s.to_i == 0)&&(s.to_i.to_s == s)) #输入0直接退出
	puts"请输入一个整数" if(s.to_i.to_s != s)
	puts"超出范围，请重新输入" if(((s.to_i<1)||(s.to_i>100))&&(s.to_i.to_s == s))
	s=gets.chomp
end
s=s.to_i
puts "1-#{s}的斐波那契数列如下"
while f3 <= s
puts f3
f3=f2+f1
f1,f2=f2,f3
end