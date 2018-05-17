-- t = time == running time. How much time has passed *right now*
-- b = begin == starting property value
-- c = change == ending - beginning
-- d = duration == how much time has to pass for the tweening to complete
local function linear(t, b, c, d) return c * t / d + b end

local function Tween(t, subject, target, easing)
    local change = {}
    for k, v in pairs(target) do
        change[k] = target[k] - subject[k]
    end

    local tween = {
        timer = t,
        subject = subject,
        target = target,
        easing = easing or linear,

        currentTime = 0,
        change = change,
    }

    function tween:update(dt)
        if self.currentTime <= self.timer then
            self.currentTime = self.currentTime + dt
            for k, v in pairs(self.target) do
                self.subject[k] = self.easing(self.currentTime, self.target[k] - self.change[k], self.change[k], self.timer)
            end
        end
    end

    return tween
end

return Tween
