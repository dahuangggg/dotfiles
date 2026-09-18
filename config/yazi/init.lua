-- Keep the status bar on the final terminal row.
function Root:layout()
	self._chunks = ui.Layout()
		:direction(ui.Layout.VERTICAL)
		:constraints {
			ui.Constraint.Length(1),
			ui.Constraint.Length(Tabs.height()),
			ui.Constraint.Fill(1),
			ui.Constraint.Length(1),
		}
		:split(self._area)
end

-- Keep permissions, percentage, and position as one contiguous right block.
function Status:percent()
	local percent = 0
	local cursor = self._current.cursor
	local length = #self._current.files

	if cursor ~= 0 and length ~= 0 then
		percent = math.floor((cursor + 1) * 100 / length)
	end

	if percent == 0 then
		percent = " Top "
	elseif percent == 100 then
		percent = " Bot "
	else
		percent = string.format(" %2d%% ", percent)
	end

	return ui.Line {
		ui.Span(percent):style(self:style().alt),
	}
end
