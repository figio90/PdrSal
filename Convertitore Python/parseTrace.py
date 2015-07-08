import os
import struct
import math

def parseBinary(filename):
    timestamps = []
    sensorTypes = []
    readings = list()
    with open(filename, 'rb') as f:
        while True:
            ts_f = f.read(8)
            st_f = f.read(1)
            x_f = f.read(4) 
            y_f = f.read(4)
            z_f = f.read(4)
            if ts_f and st_f and x_f and y_f and z_f:
                ts=struct.unpack('>q',ts_f)[0] #long long
                timestamps.append(ts)
                st=ord(struct.unpack('>c',st_f)[0]) #char to int
                sensorTypes.append(st)
                x = struct.unpack('>f',x_f)[0]
                y = struct.unpack('>f',y_f)[0]
                z = struct.unpack('>f',z_f)[0]
                readings.append([x, y, z])
            else:
                break
    return (timestamps, sensorTypes, readings)


def main():
    # i .dat convertiti li mettiamo in una cartella 'conv'
    # prima controlliamo se esiste
    if os.path.exists("conv"):
        print("Gia convertiti, usciamo")
        return

    # se non esiste la creiamo e ci mettiamo i files
    os.mkdir("conv")
    print("Starting conversion")

    # scorriamo tutti i file della cartella corrente
    for filename in os.listdir('.'):

        # se non ha '.out' nel nome, lo saltiamo
        if ".out" not in filename:
            print("skipped " + filename)
            continue

        # altrimenti lo convertiamo
        print("converting " + filename)

        # apriamo il file .out
        with open(filename) as f:
            # usiamo la funzione parseBinary presa dallo script per leggerlo
            # salvando le 5 colonne di dati presenti nel file
            timestamps, sensorTypes, readings = parseBinary(filename)
            
            # creiamo un nuovo file nella cartella 'conv'
            # il nome è lo stesso ma cambiamo l'estensione
            new_file = "conv/" + filename.replace("out", "dat")
            with open(new_file, "w") as f2:
                # per 'i' che va da 0 alla lunghezza 
				#della lista con i timestamps
                for i in range(len(timestamps)):
                    # scriviamo sul file nuovo 
                    #le prime due colonne (convertendo i numeri in stringhe)
                    f2.write(str(str(timestamps[i]) + " " + str(sensorTypes[i]) + " "))
                    # e le ultime tre (togliendo le [] che hanno attorno)
                    f2.write(str(readings[i]).replace("[", "").replace("]", ""))
                    f2.write("\n")

                    
if __name__ == "__main__":
    main()
   
