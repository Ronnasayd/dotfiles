import requests
import datetime

def main():
  response = requests.get("https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5o7NI3KjKdq_yxt8dmFbIuj8o5mlw4cdlv3Qi-IcBw4HBBeQx4UPbRE4tiqjV-hGu6on3kJ2e2dHo/pub?output=csv")
  lines  = response.text.split("\n")
  now = datetime.datetime.now()
  counter = 0
  content = ""
  if len(lines) > 1:
    for line in lines[1:]:
      if counter > 4:
        break
      terms = line.split(",")
      title = terms[1][:30]
      start_raw = terms[2]
      end_raw = terms[3]
      # description = terms[4]
      start = datetime.datetime.strptime(start_raw,"%d/%m/%Y %H:%M:%S")
      start_string = start.strftime("%d/%m %H:%M")
      end = datetime.datetime.strptime(end_raw,"%d/%m/%Y %H:%M:%S")
      end_string = end.strftime("%H:%M")
      if now < end:
        counter += 1
        line = f"offset|{start_string} to {end_string} - {title}\n"
        content += line
        print(line)
    if counter > 0:
      with open("/tmp/conky-calendar", "w") as file:
        file.write(content)
        file.write("\n"*max(4 - counter,0))

if __name__ == "__main__":
  main()