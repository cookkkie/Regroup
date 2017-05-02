defmodule Regroup do
  def start_link do
    :pg2.start_link()
  end

  def register(key, pid) do
    :pg2.create(key)
    :pg2.join(key, pid)
  end

  def lookup(key) do
    case :pg2.get_members(key) do
      [pid|_] -> pid
      _ -> nil
    end
  end

  def join(key, pid) do
    :pg2.create(key)
    :pg2.join(key, pid)
  end

  def members(key) do
    case :pg2.get_members(key) do
      [_h|_t] = group -> group
      _ -> []
    end
  end
end
