using Microsoft.AspNetCore.Mvc;

namespace EcsFargateRollingUpdate.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class SampleController : ControllerBase
    {
        [HttpGet]
        public IActionResult Test()
        {
            return Ok("Healthy");
        }
    }
}
