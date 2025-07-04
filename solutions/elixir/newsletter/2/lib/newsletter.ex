defmodule Newsletter do

  def read_emails(path) do
    {res, m} = File.read(path)
      if res == :ok and m != "" do
        m |> String.trim
          |> String.split("\n")
      else
        []
      end
  end

  def open_log(path) do
    {res, pid} = File.open(path, [:write])
    if res == :ok do
      pid
    end
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)
    read_emails(emails_path)
      |> Enum.each(fn(email) -> 
        if send_fun.(email) == :ok do
          log_sent_email(pid, email)
        end
      end)
    close_log(pid)
  end
end
