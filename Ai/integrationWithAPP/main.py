from fastapi import Request, FastAPI
#loading model from sklearn
from joblib import load
"""model input parameters as following 
    arrangemnet is important 
    {
        0:magError        ,1:horizontalError      ,2:depthError       ,3:nst             ,
        4:magNst          ,5:dmin                 ,6:magSource()      ,7:magSource()     ,
        8:magSource()     ,9:magSource()          ,10:magType()       ,11:magType()      ,
        12:magType()      ,13:magType()           ,14:magType()       ,15:magType()      ,
        16:magType()      ,17:magType()           ,18:lat             ,19:long           ,
        20:depth          ,21:gap                 ,22:rms             ,23:(mag) our target   
    }

"""

model = load("tree_model.joblib")

app = FastAPI()

@app.post("/predict")
@app.get("/")
async def read_root():
    return {"message": "Hello, welcome to the FastAPI app!"}
async def get_prediction(req: Request):
    inp = await req.json()
    # inputs needed 

    magError             = inp["magError"]
    horizontalError      = inp["horizontalError"]
    depthError           = inp["depthError"]
    nst                  = inp["nst"]
    magNst               = inp["magNst"]
    dmin                 = inp["dmin"]
    magSource_gcmt       = inp["gcmt"]
    magSource_nied       = inp["nied"]
    magSource_official   = inp["official"]
    magSource_us         = inp["us"]
    magType_mb           = inp["mb"]
    magType_mb_lg        = inp["mb_lg"]
    magType_ml           = inp["ml"]
    magType_ms           = inp["ms"]
    magType_mwb          = inp["mwb"]
    magType_mwc          = inp["mwc"]
    magType_mwr          = inp["mwr"]
    magType_mww          = inp["mww"]
    lat                  = inp["lat"]
    lon                  = inp["lon"]
    depth                = inp["depth"]
    gap                  = inp["gap"]
    rms                  = inp["rms"]


    prediction = model.predict([[magError ,horizontalError ,depthError ,nst ,magNst, dmin ,magSource_gcmt,
                                magSource_nied, magSource_official ,magSource_us, magType_mb,
                                magType_mb_lg, magType_ml,magType_ms, magType_mwb,
                                magType_mwc, magType_mwr, magType_mww, lat, lon,
                                depth, gap, rms
                                ]])

    return {"prediction": prediction[0]}