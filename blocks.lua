local blocks = {}

function blocks:setup(setupTable)
	self.blocks = {}
	for i = 1, #setupTable do 
		local setupItem = setupTable[i]
	end
end

function blocks:split(point)

end

function blocks:merge(point, direction)

end

function blocks:swap(point, direction)

end

return blocks