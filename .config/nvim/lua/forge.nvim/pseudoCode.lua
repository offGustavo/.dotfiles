local M = {}

local config = vim.tbl_extend("force", {
	default_compile_command = "make -k",
}, vim.g.forge_compile_config or {})

---@param nil
---@return string
--- Get user cmd
local getCmd = function()
	return vim.fn.input({
		prompt = "Compile: ",
		default = config.default_compile_command,
		completion = "shellcmd", -- For shell commands
		-- completion = 'file',    -- For files
		-- completion = 'dir',     -- For directories
	})
end


local fn getCmd()
    return vim.fn.input()
nf

local runCmd = fn()
    if { cmd = getCmd() } == in
        case "" return esac
        case nil return esac
        case "cmd" 
            return cmd .. "cmd"  
        esac
        default return getCmd() esac
    fi
    vim.cmd(cmd)
nf

New = fn(o)
return ok, copy(o)
nf

-- {} is a object
ok, class User = New({})

if ok then

    User:name string 
    User:cpf integer
    User:age integer
        
    User:newUser = fn({ name:string, cpf:integer, age:Date})
        this:name = name;
        this:cpf = cpf;
        this:age = age;
    nf
fi


class Date = {
    day: integer,
    mounth: integer,
    year: interger,
    unixEpoch: 32i,
    new = fn(d[string,32i])
        if d == string then
           this:day, this:mounth, this:year = string.split(d, "/")
        else
            this,unixEpoch = d
        fi
    nf,
}

if  local myUser = new(User) then
    myUser:newUser("Luiz", 40023922, Date:new("23/12/2003"))
fi

otherUser:newUser("Gustavo", 28382838, date = Date:new(1072137600000)




M.compile = runCmd()

return M
