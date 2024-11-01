import requests
import datetime

def main():
  with open("/tmp/conky-calendar", "w") as file:
    response = requests.get("https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5o7NI3KjKdq_yxt8dmFbIuj8o5mlw4cdlv3Qi-IcBw4HBBeQx4UPbRE4tiqjV-hGu6on3kJ2e2dHo/pub?output=csv")
    lines  = response.text.split("\n")
    for line in lines[1:]:
      terms = line.split(",")
      title = terms[1][:30]
      start = terms[2]
      end = terms[3]
      # description = terms[4]
      start = datetime.datetime.strptime(start,"%d/%m/%Y %H:%M:%S").strftime("%d/%m %H:%M")
      end = datetime.datetime.strptime(end,"%d/%m/%Y %H:%M:%S").strftime("%H:%M")
      line = f"offset|{start} to {end} - {title}\n"
      file.write(line)
      print(line)

if __name__ == "__main__":
  main()