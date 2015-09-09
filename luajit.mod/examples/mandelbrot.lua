--jit.off()

local BAILOUT = 16
local MAX_ITERATIONS = 100000

function iterate(x,y)

	local cr = y-0.8
	local ci = x
	local zi = 0.0
	local zr = 0.0
	local i = 0
	
	while 1 do
		i = i+1
		local temp = zr * zi
		local zr2 = zr*zr
		local zi2 = zi*zi
		zr = zr2-zi2+cr
		zi = temp+temp+ci
		if (zi2+zr2 > BAILOUT) then
			return i
		end
		
		if (i > MAX_ITERATIONS) then
			return 0
		end
	end

end

function mandelbrot()
	local t = os.time()
	local s=""
	for y = -39, 38 do
		for x = -39, 38 do
			if (iterate(x/40.0, y/40) == 0) then
				--io.write("*")
				s=s.."*"
			else
				--io.write(" ")
				s=s.." "
			end
		end
		--io.write(s.."\n")
		s=s.."\n"
	end
	t=os.time()-t
	print(s)
	io.write(string.format("Time Elapsed %d\n", t))
end

jit.opt.start(2)

jit.on()
if jit.status()==true then
	print "JIT ON"
else
	print "JIT OFF"
end
mandelbrot()
jit.off()
if jit.status()==true then
	print "JIT ON"
else
	print "JIT OFF"
end
mandelbrot()
print("LuaJIT version: "..jit.version)





