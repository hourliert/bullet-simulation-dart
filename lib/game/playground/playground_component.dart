import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:angular2/core.dart';

import 'package:bullet_simulation/game/shared/game_service.dart';
import 'package:bullet_simulation/game/shared/physic_service.dart';
import 'package:bullet_simulation/game/shared/renderer_service.dart';
import 'package:bullet_simulation/shared/list_service.dart';
import 'package:bullet_simulation/shared/bullet_model.dart';
import 'package:bullet_simulation/shared/renderer_type.dart';

import 'package:bullet_simulation/game/shared/stage_model.dart';
import 'package:bullet_simulation/game/shared/circle_model.dart';
import 'package:bullet_simulation/game/shared/game_renderer.dart';
import 'package:bullet_simulation/game/shared/canvas_game_renderer.dart'
    deferred as canvas_game_renderer;
import 'package:bullet_simulation/game/shared/svg_game_renderer.dart'
    deferred as svg_game_renderer;

@Component(
    selector: 'bs-playground',
    template: '',
    styleUrls: const ['./playground_component.css'],
    providers: const [ListService, RendererService, PhysicService, GameService])
class PlaygroundComponent implements OnInit, OnChanges, OnDestroy {
  @Input()
  RendererType rendererType;

  @Output()
  final EventEmitter<Bullet> bulletHitsBorder = new EventEmitter<Bullet>();

  ElementRef _elementRef;
  GameService _gameService;
  RendererService _rendererService;
  PhysicService _physicService;
  ListService<Bullet> _bulletService;

  GameRenderer _currentRenderer;
  StreamSubscription<Rectangle<int>> _onResizeSubscription;
  StreamSubscription<Stage> _onBeforeRenderSubscription;
  StreamSubscription<Circle> _onRenderCircleSubscription;

  PlaygroundComponent(this._elementRef, this._gameService, this._physicService,
      this._rendererService, this._bulletService);

  @override
  Future<Null> ngOnInit() async {
    Element element = _elementRef.nativeElement;
    _physicService.updateBoundaries(
        element.client.width, element.client.height);

    _gameService.loop();
    _physicService.onBulletHitBorder.listen(_onBulletHitsBorder);
  }

  @override
  Future<Null> ngOnChanges(Map<String, SimpleChange> changes) async {
    Element element = _elementRef.nativeElement;

    if (changes['rendererType'] != null) {
      await _detachRenderer();
      await _attachRenderer(element, changes['rendererType'].currentValue);
    }
  }

  @override
  void ngOnDestroy() {
    _currentRenderer.destroyDom();
  }

  @HostListener('window:resize', const ['\$event'])
  void onResize(Event e) {
    Window window = e.target;
    _physicService.updateBoundaries(window.innerWidth, window.innerHeight);
  }

  @HostListener('click', const ['\$event'])
  void onClick(MouseEvent e) {
    Bullet b = new Bullet(e.client.x, e.client.y);
    _bulletService.add(b);
  }

  void _onBulletHitsBorder(Bullet b) {
    _bulletService.remove(b);
    bulletHitsBorder.add(b);
  }

  Future<Null> _attachRenderer(Element parentElement, RendererType type) async {
    if (_currentRenderer != null) return;

    switch (type) {
      case RendererType.SVG:
        await svg_game_renderer.loadLibrary();
        _currentRenderer = new svg_game_renderer.SvgGameRenderer();
        break;
      case RendererType.CANVAS:
      default:
        await canvas_game_renderer.loadLibrary();
        _currentRenderer = new canvas_game_renderer.CanvasGameRenderer();
        break;
    }

    _currentRenderer.createDom(parentElement);

    _onResizeSubscription =
        _physicService.onResize.listen(_currentRenderer.updateSize);
    _onBeforeRenderSubscription =
        _rendererService.onBeforeRender.listen(_currentRenderer.clearStage);
    _onRenderCircleSubscription =
        _rendererService.onRenderCircle.listen(_currentRenderer.drawCircle);
  }

  Future<Null> _detachRenderer() async {
    if (_currentRenderer == null) return;

    await _onResizeSubscription.cancel();
    await _onBeforeRenderSubscription.cancel();
    await _onRenderCircleSubscription.cancel();

    _currentRenderer.destroyDom();

    _currentRenderer = null;
  }
}
