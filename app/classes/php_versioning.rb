# Port of PHP's version_compare function (http://php.net/version_compare)
class PHPVersioning

  def self.compare(ver1, ver2)
    if !ver1 || !ver2
      if !ver1 && !ver2
        return 0;
      else
        return ver1 ? 1 : -1;
      end
    end

    ver1 = canonicalize(ver1).split(".")
    ver2 = canonicalize(ver2).split(".")

    if ver1.length < ver2.length
      ver1.concat([0] * (ver2.length - ver1.length))
    elsif ver1.length > ver2.length
      ver2.concat([0] * (ver1.length - ver2.length))
    end

    ver1.each_index do |i|
      a = ver1[i]
      b = ver2[i]

      if isdigit(a) && isdigit(b)
        compare = sign(a.to_i - b.to_i)
      elsif !isdigit(a) && !isdigit(b)
        compare = compare_special_forms(a, b)
      else
        if isdigit(a)
          compare = compare_special_forms("#N#", b)
        else
          compare = compare_special_forms(a, "#N#")
        end
      end

      if compare != 0
        return compare
      end
    end

    return 0
  end

  private

	def self.canonicalize(ver)
		if ver.size == 0
			return "";
		end

    can = lc = ""

		ver.each_char do |c|
      if isspecialver(c)
        if can[-1] != "."
          can << "."
        end
      elsif (isndig(lc) && isdig(c)) || (isdig(lc) && isndig(c))
        if can[-1] != "."
          can << "."
        end
        can << c
      elsif !isalnum(c)
        if can[-1] != "."
          can << "."
        end
      else
        can << c
      end
		end

    return can
	end

  def self.compare_special_forms(form1, form2)
    found1 = found2 = -1
    table = Hash["dev", 0, "alpha", 1, "a", 1, "beta", 2, "b", 2, "RC", 3, "rc", 3, "#", 4, "pl", 5, "p", 5, "", 0]

    table.each do |k, v|
      if form1[k]
        found1 = v
        break
      end
    end

    table.each do |k, v|
      if form2[k]
        found2 = v
        break
      end
    end

    return sign(found1 - found2)
  end

  def self.isdigit(x)
    x.is_a?(Fixnum) || !!x.match(/[0-9]/)
  end

	def self.isdig(x)
		x.is_a?(Fixnum) || (!!x.match(/[0-9]/) && x != ".")
	end

	def self.isndig(x)
		!x.match(/[0-9]/) && x != "."
	end

	def self.isspecialver(x)
		x == "-" || x == "_" || x == "+"
	end

  def self.isalnum(x)
    !!x.match(/[0-9a-z]/i)
  end

  def self.sign(x)
    x < 0 ? -1 : (x > 0 ? 1 : 0 )
  end
end
